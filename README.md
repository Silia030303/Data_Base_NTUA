# Data_Base_NTUA

\documentclass{article}
\usepackage{listings}
\usepackage{color}
\usepackage{hyperref}
\usepackage[utf8]{inputenc}

\title{Project84\_DB\_2024 - README}
\author{}
\date{}

\begin{document}

\maketitle

\section*{Περιγραφή}

Ο κώδικας στο αρχείο \texttt{mastercef.sql} δημιουργεί μια βάση δεδομένων \texttt{project84\_DB\_2024} με αρκετούς πίνακες, σχέσεις και προβολές (views) που σχετίζονται με μια εφαρμογή που διαχειρίζεται συνταγές, μάγειρες, αξιολογήσεις, εξοπλισμό και άλλα στοιχεία μαγειρικής. Ακολουθεί μια περιγραφή των κύριων στοιχείων του κώδικα:

\section*{1. Δημιουργία της βάσης δεδομένων}

\begin{lstlisting}[language=SQL]
DROP DATABASE IF EXISTS project84_DB_2024;
CREATE database project84_DB_2024;
USE project84_DB_2024;
\end{lstlisting}

Αρχικά, η βάση δεδομένων \texttt{project84\_DB\_2024} διαγράφεται εάν υπάρχει, και στη συνέχεια δημιουργείται εκ νέου και επιλέγεται για χρήση.

\section*{2. Δημιουργία πινάκων}

\subsection*{Πίνακες βασικών δεδομένων}

\begin{itemize}
    \item \texttt{equipment}: Αποθηκεύει πληροφορίες για τον εξοπλισμό που χρησιμοποιείται στις συνταγές.
    \item \texttt{foodgroups}: Περιέχει τις κατηγορίες τροφίμων.
    \item \texttt{national\_cuisine}: Αποθηκεύει πληροφορίες για τις εθνικές κουζίνες.
    \item \texttt{meal\_type}: Κατηγοριοποιεί τις συνταγές με βάση τον τύπο γεύματος (π.χ., πρωινό, μεσημεριανό).
    \item \texttt{ingredient}: Περιέχει τα συστατικά των συνταγών, με αναφορές στις κατηγορίες τροφίμων (\texttt{foodgroups}).
    \item \texttt{recipe}: Περιέχει τις συνταγές, συμπεριλαμβανομένων λεπτομερειών όπως η κατηγορία, η κουζίνα, τα κύρια συστατικά, οι χρόνοι προετοιμασίας και μαγειρέματος, και οι διατροφικές πληροφορίες.
    \item \texttt{tags}: Περιέχει ετικέτες για τις συνταγές.
    \item \texttt{episode}: Αποθηκεύει τα επεισόδια ενός μαγειρικού διαγωνισμού.
    \item \texttt{cook}: Περιέχει πληροφορίες για τους μάγειρες.
    \item \texttt{judge}: Αποθηκεύει τους κριτές, οι οποίοι είναι επίσης μάγειρες, και τα επεισόδια στα οποία συμμετέχουν ως κριτές.
    \item \texttt{recipe\_step}: Περιέχει τα βήματα των συνταγών.
    \item \texttt{thematic\_section}: Περιέχει θεματικές ενότητες στις οποίες μπορεί να ανήκουν οι συνταγές.
\end{itemize}

\subsection*{Πίνακες σχέσεων}

\begin{itemize}
    \item \texttt{recipe\_equipment}: Συνδέει συνταγές με τον εξοπλισμό που χρησιμοποιείται.
    \item \texttt{ingredient\_VS\_recipe}: Συνδέει συνταγές με τα συστατικά τους, μαζί με τις ποσότητες και τις θερμίδες.
    \item \texttt{recipe\_tag}: Συνδέει συνταγές με ετικέτες.
    \item \texttt{recipe\_meal\_type}: Συνδέει συνταγές με τύπους γεύματος.
    \item \texttt{episode\_cook\_recipe}: Συνδέει μάγειρες, επεισόδια και συνταγές.
    \item \texttt{cook\_natcuis}: Συνδέει μάγειρες με εθνικές κουζίνες.
    \item \texttt{recipe\_thematic\_section}: Συνδέει συνταγές με θεματικές ενότητες.
\end{itemize}

\subsection*{Πίνακας αξιολογήσεων}

\begin{itemize}
    \item \texttt{evaluation}: Αποθηκεύει τις αξιολογήσεις που δίνουν οι κριτές στις συνταγές των μαγείρων.
\end{itemize}

\section*{3. Δημιουργία προβολών (Views)}

\begin{itemize}
    \item \texttt{recipe\_nutritional\_info\_vw}: Αυτή η προβολή παρέχει πληροφορίες για τις θερμίδες ανά μερίδα των συνταγών.
    \item \texttt{winner\_vw}: Αυτή η προβολή υπολογίζει τον νικητή κάθε επεισοδίου βασιζόμενη στη βαθμολογία των μαγείρων.
\end{itemize}

\section*{Triggers}

Ο κώδικας στο αρχείο \texttt{Triggers.sql} περιλαμβάνει τη δημιουργία triggers στη βάση δεδομένων \texttt{project84\_DB\_2024}. Αυτοί οι triggers εκτελούν συγκεκριμένες ενέργειες πριν την εισαγωγή ή την ενημέρωση δεδομένων σε ορισμένους πίνακες, ώστε να εξασφαλιστεί η ακεραιότητα των δεδομένων και να εφαρμοστούν επιχειρηματικοί κανόνες. Ακολουθεί μια περιγραφή των triggers που δημιουργήθηκαν:

\subsection*{Triggers για τον πίνακα \texttt{ingredient\_VS\_recipe}}

\begin{itemize}
    \item \texttt{check\_unit\_of\_measurement\_insert}:
        \begin{itemize}
            \item Ελέγχει αν η τιμή της στήλης \texttt{unit\_of\_measurement} είναι μία από τις επιτρεπόμενες τιμές πριν την εισαγωγή δεδομένων. Εάν δεν είναι, απορρίπτει την εισαγωγή και εμφανίζει μήνυμα σφάλματος.
        \end{itemize}
    \item \texttt{check\_unit\_of\_measurement\_update}:
        \begin{itemize}
            \item Παρόμοιος με τον προηγούμενο, ελέγχει τις επιτρεπόμενες τιμές της \texttt{unit\_of\_measurement} πριν την ενημέρωση δεδομένων.
        \end{itemize}
\end{itemize}

\subsection*{Triggers για τον πίνακα \texttt{foodgroups}}

\begin{itemize}
    \item \texttt{check\_foodgroups\_update}:
        \begin{itemize}
            \item Ελέγχει αν το \texttt{foodgroups\_name} είναι μία από τις καθορισμένες επιτρεπόμενες τιμές πριν την εισαγωγή δεδομένων.
        \end{itemize}
\end{itemize}

\subsection*{Triggers για τον πίνακα \texttt{ingredient}}

\begin{itemize}
    \item \texttt{check\_foodgroups\_update\_in\_ingredient}:
        \begin{itemize}
            \item Ελέγχει αν το \texttt{foodgroups\_id} είναι ένα από τα καθορισμένα επιτρεπόμενα IDs πριν την εισαγωγή δεδομένων.
        \end{itemize}
\end{itemize}

\subsection*{Triggers για τον πίνακα \texttt{episode\_cook\_recipe}}

\begin{itemize}
    \item \texttt{before\_episode\_cook\_recipe\_insert}:
        \begin{itemize}
            \item Ελέγχει αν ο αριθμός των συνταγών και μαγείρων ανά επεισόδιο δεν υπερβαίνει τις 10 πριν την εισαγωγή στον πίνακα \texttt{episode\_cook\_recipe}.
        \end{itemize}
    \item \texttt{before\_episode\_cook\_insert}:
        \begin{itemize}
            \item Ελέγχει αν ένας μάγειρας δεν συμμετέχει σε τρία συνεχόμενα επεισόδια πριν την εισαγωγή στον πίνακα \texttt{episode\_cook\_recipe}.
        \end{itemize}
\end{itemize}

\subsection*{Triggers για τον πίνακα \texttt{recipe\_step}}

\begin{itemize}
    \item \texttt{check\_sequential\_steps}:
        \begin{itemize}
            \item Ελέγχει αν κάθε βήμα μιας συνταγής έχει το αμέσως προηγούμενο βήμα πριν την εισαγωγή του στον πίνακα \texttt{recipe\_step}.
        \end{itemize}
    \item \texttt{check\_step\_serial\_number}:
        \begin{itemize}
            \item Ελέγχει αν υπάρχει ήδη βήμα με τον ίδιο σειριακό αριθμό για μια συγκεκριμένη συνταγή πριν την εισαγωγή του στον πίνακα \texttt{recipe\_step}.
        \end{itemize}
\end{itemize}

\end{document}
