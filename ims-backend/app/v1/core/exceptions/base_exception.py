class BaseException(Exception):
    """
    Base class for other exceptions
    """

    _message: str = 'Server Internal Error'

    def __str__(self):
        return self._message
