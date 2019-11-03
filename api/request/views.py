from django.shortcuts import get_object_or_404
from rest_framework import viewsets, generics
from rest_framework.response import Response
from .models import HelpRequest
from .serializers import HelpRequestSerializer


class HelpRequestViewSet(viewsets.ViewSet):
    """
    A simple ViewSet for listing or retrieving help requests.
    """

    def list(self, request):
        queryset = HelpRequest.objects.all()
        serializer = HelpRequestSerializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        queryset = HelpRequest.objects.all()
        user = get_object_or_404(queryset, pk=pk)
        serializer = HelpRequestSerializer(user)
        return Response(serializer.data)


class HelpRequestCreate(generics.CreateAPIView):
    queryset = HelpRequest.objects.all()
    serializer_class = HelpRequestSerializer


class HelpRequestDestroy(generics.DestroyAPIView):
    queryset = HelpRequest.objects.all()
    serializer_class = HelpRequestSerializer
