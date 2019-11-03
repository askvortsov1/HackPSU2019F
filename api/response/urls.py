from rest_framework.routers import DefaultRouter
from .views import HelpResponseViewSet, HelpResponseCreate, HelpResponseDestroy
from django.urls import path

urlpatterns = [
    path('response/create/', HelpResponseCreate),
    path('response/destroy/', HelpResponseDestroy),
]
router = DefaultRouter()
router.register(r'response', HelpResponseViewSet, basename='user')
urlpatterns += router.urls