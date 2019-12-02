from django.urls import path, include
from drf.views import views as drf_views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('users', drf_views.user_viewset )


urlpatterns = [
    path( 'api-users' include(router.urls) )
    path('admin/', admin.site.urls),
    
    path( 'api-auth/', include('rest_framework.urls', namespace='rest_framework') )

]