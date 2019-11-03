
from rest_framework.serializers import ModelSerializer
from .models import HelpRequest


class HelpRequestSerializer(ModelSerializer):
    class Meta:
        model = HelpRequest
        fields = ['id', 'user', 'item', 'item_description', 'severity', 'severity_detail']