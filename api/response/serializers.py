
from rest_framework.serializers import ModelSerializer
from .models import HelpResponse


class HelpRequestSerializer(ModelSerializer):
    class Meta:
        model = HelpResponse
        fields = ['id', 'request', 'assisting_user', 'datetime']
