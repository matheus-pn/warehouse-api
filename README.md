# Warehouse-API
> Proof of concept / Learning playground

Sometimes stock management is complicated, and needs to resolve dependencies in real time.


Imagine a company that provides customizable fashion accessories to their customers with a Just in Time production.
Based on a real story.

Suppose this company has some product parts on stock, 30 units of "Part A" and 80 units of "Part B" on "Inventory Centre 1" and 20 more units of each part on "Inventory Centre 2".
They sell a product named "Product B", that's assembled using 1 unit of "Part A" and 2 units of "Part C" just before being packed.
However on their website, they sell multiple variants of Product B, depending on the color the client chooses "Product B - Blue", "Product B - Red" ...

```
Inventory 1
Product B - Blue -------|                   |- 1x --> Part A (30 un.)
Product B - Red  -------+---> Product B ----+
...                   ...                   |- 2x --> Part B (80 un.)
Product B - XYZ --------|

Inventory 2
Product B - Blue -------|                   |- 1x --> Part A (20 un.)
Product B - Red  -------+---> Product B ----+
...                   ...                   |- 2x --> Part B (20 un.)
Product B - XYZ --------|

======================================================================
Virtual Website Inventory (50 units of B available)
Product B - Blue -------|                   |- 1x --> Part A (50 un.)
Product B - Red  -------+---> Product B ----+
...                   ...                   |- 2x --> Part B (100 un.)
Product B - XYZ --------|
```

When does "Product B - Red", go out of stock on Region X (Considering very fast assembly times)?

This system is an attempt answer to this question, but with arbitrarily large dependency trees.


<img src="http://wandora.org/w/images/Tree_graph_example.gif" width="400" height="400" />


This project also is an exploration on: 
  - API user authentication (Never roll your own auth, I know, but I did anyway for science)
  - Rails project structure for APIs with lots of business rules Flow/Model/Controller
  - Use of PORO service objects instead of callbacks on creation/deletion.
  - Using `WITH RECURSIVE` database queries and trying to integrate somehow on active record.
