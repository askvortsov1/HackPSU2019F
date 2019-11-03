from django.shortcuts import get_object_or_404
from rest_framework import viewsets, generics
from rest_framework.response import Response
from .models import HelpResponse
from .serializers import HelpResponseSerializer


class HelpResponseViewSet(viewsets.ViewSet):
    """
    A simple ViewSet for listing or retrieving help responses.
    """

    def list(self, response):
        queryset = HelpResponse.objects.all()
        serializer = HelpResponseSerializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, response, pk=None):
        queryset = HelpResponse.objects.all()
        user = get_object_or_404(queryset, pk=pk)
        serializer = HelpResponseSerializer(user)
        return Response(serializer.data)


class HelpResponseCreate(generics.CreateAPIView):
    queryset = HelpResponse.objects.all()
    serializer_class = HelpResponseSerializer


class HelpResponseDestroy(generics.DestroyAPIView):
    queryset = HelpResponse.objects.all()
    serializer_class = HelpResponseSerializer
