<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8" />
  <title>MT sample</title>
 </head>
 <body>

  <ol>
? while (my ($isbn, $book) = each %{ $stash->{books} }) {
   <li><?= $book->{name} ?> - <?= $book->{pages} ?> pages / ISBN-13 : <?= $isbn ?></li>
? }
  </ol>

  <pre>
   $books = <?= dump $stash->{books} ?>
  </pre>

?= $stash->{html}

 </body>
</html>
