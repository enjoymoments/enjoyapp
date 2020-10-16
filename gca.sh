#!/bin/bash

gca bloc --name $1 --project $2 && gca event --name $1 && gca state --name $1 && gca datasource --name $1 --project $2 && gca domainrepository --name $1 && gca entitie --name $1 && gca model --name $1 --project $2 && gca repository --name $1 --project $2 && gca page --name $1 && gca usecase --name $1