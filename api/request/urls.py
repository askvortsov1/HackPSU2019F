from rest_framework.routers import DefaultRouter
from .views import HelpRequestViewSet


router = DefaultRouter()
router.register(r'requests', HelpRequestViewSet, basename='user')
urlpatterns = router.urls
