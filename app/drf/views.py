from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from drf.serializers import user_serializer

class user_viewset(viewsets.ModelViewSet):
    """ note:
    - api endpoint that allows `users` to be viewed and edited
    """
    queryset = User.objects.all()
    serializer_class = user_serializer
