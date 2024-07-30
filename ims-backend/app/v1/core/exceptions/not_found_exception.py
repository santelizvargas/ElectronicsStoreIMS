from v1.core.exceptions.base_exception import BaseException

class NotFoundException(BaseException):
    """
    Exception raised for not found error (404)
    """

    _message: str = 'Not Found'

    def __init__(self, message):
        self.message = message