# Zadanie 5: Sortowanie topologiczne

Sortowanie topologiczne polega na rozszerzeniu grafu skierowanego bez cykli (DAG-u) do porządku liniowego.

Mówiąc prościej, mając dany DAG należy przypisać wierzchołkom takie różne liczby naturalne (nadające kolejność tym wierzchołkom), żeby dla każdej krawędzi grafu jej źródło miało niższy numer niż jej cel.

Mówiąc jeszcze prościej, mając daną częściową informację o zależności np. czynności od siebie (np. buty wkładamy po skarpetkach, krawat po koszuli itp. ale kolejność wkładania skarpetek i koszuli może być dowolna) mamy wygenerować ścisłą kolejność wykonywania czynności (np. koszula, skarpetki, buty, krawat).

Konkretnie należy zaprogramować implementację topol.ml załączonej specyfikacji [**topol.mli**](https://github.com/kfernandez31/WPF-5-Topological-Sort/blob/main/src/topol.mli).


W implementacji można korzystać z modułu [**pMap**](https://github.com/kfernandez31/WPF-5-Topological-Sort/blob/main/src/pMap.mli) (bardzo podobnego do [**pSet**](https://github.com/kfernandez31/WPF-3-Integer-Set/blob/main/src/pSet.mli) z zadania z drzewami AVL), którego specyfikacja i implementacja również są załączone. 
