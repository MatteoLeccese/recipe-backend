import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { ApiResponse } from '../interfaces/api-response.interface';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const message =
      exception instanceof HttpException
        ? exception.getResponse()
        : 'Internal server error';

    // Normalize message if it's an object from NestJS (e.g. validaton errors)
    const normalizedMessage = typeof message === 'object' && message !== null && 'message' in message
        ? (message as any).message
        : message;

    // Ensure normalizedMessage is a string or join array of strings
    const errorMessage = Array.isArray(normalizedMessage) 
        ? normalizedMessage.join(', ') 
        : String(normalizedMessage);

    const errorResponse: ApiResponse<null> = {
      error: errorMessage,
      message: 'Operation failed',
      data: null,
    };

    response.status(status).json(errorResponse);
  }
}
