package com.ewatts.electricalreadings.exception;

class BadRequestException extends ResourceNotFoundException {
  public BadRequestException(String message) {
    super(message);
  }
}
