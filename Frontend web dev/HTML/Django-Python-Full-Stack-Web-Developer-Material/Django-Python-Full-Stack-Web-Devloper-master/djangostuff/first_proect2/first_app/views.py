from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse

def index(res):
    my_dict={'insert_me':'this from veiws'}
    return render(res,'first_app/index.html',context=my_dict)
