
from rest_framework.serializers import ModelSerializer
from .models import HelpResponse


class HelpResponseSerializer(ModelSerializer):
    class Meta:
        model = HelpResponse
        fields = ['id', 'request', 'assisting_user', 'datetime']
