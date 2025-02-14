CMPE
 
343
 
Logistic
  
Regression
 
Analysis
  
 
 
I
 
chose
 
the
 
HR
 
analysis
 
dataset.
 
This,
  
examines
 
the
 
factors
 
influencing
 
employee
 
turnover
 
in
 
an
 
organization
 
using
 
the
 
HR
 
Analysis
 
dataset
 
 
 
 
General
 
information
 
about
 
the
 
dataset.
 
 
 
 
 


 
 
 
 
 
 
 
 
 
 
 
 


Correlation
 
Analysis
:
 
●
 
Satisfaction
 
Level
:
 
Strong
 
negative
 
correlation
 
with
 
turnover,
 
indicating
 
that
 
dissatisfied
 
employees
 
are
 
more
 
likely
 
to
 
leave.
 
●
 
Time
 
Spent
 
at
 
the
 
Company
:
 
Positive
 
correlation,
 
suggesting
 
longer-tenured
 
employees
 
may
 
experience
 
burnout
 
or
 
stagnation.
 
●
 
Number
 
of
 
Projects
:
 
Moderate
 
correlation
 
with
 
turnover,
 
highlighting
 
workload
 
as
 
a
 
potential
 
factor.
 
 
 
 
 
Confusion
 
Matrix
 
 
 
 
 
 


 
 
Outlier
 
Detection
 
Outliers
 
were
 
identified
 
using
 
Z-scores
 
for
 
numerical
 
variables
 
(e.g.,
 
satisfaction
 
level,
 
last
 
evaluation,
 
average
 
monthly
 
hours):
 
●
 
Employees
 
with
 
extreme
 
average
 
monthly
 
hours
 
or
 
unusually
 
high/low
 
satisfaction
 
levels
 
were
 
flagged
 
as
 
outliers.
 
●
 
Most
 
outliers
 
belonged
 
to
 
the
 
high-risk
 
turnover
 
group,
 
suggesting
 
the
 
need
 
for
 
workload
 
adjustment
 
or
 
targeted
 
retention
 
strategies.
 
 
 
 
 
 
 
Clustring
 
 
Clusters
 
Based
 
on
 
Satisfaction
 
Level
 
and
 
Last
 
Evaluation
 
Using
 
K-means
 
clustering
 
(with
 
3
 
clusters),
 
employees
 
were
 
grouped
 
based
 
on
 
their
 
satisfaction
 
levels
 
and
 
last
 
evaluation
 
scores:
 
●
 
Cluster
 
1
:
 
High
 
satisfaction,
 
high
 
evaluations
 
(most
 
likely
 
to
 
stay).
 
●
 
Cluster
 
2
:
 
Low
 
satisfaction,
 
low
 
evaluations
 
(highest
 
turnover
 
risk).
 
●
 
Cluster
 
3
:
 
Mixed
 
satisfaction
 
and
 
evaluation
 
levels
 
(moderate
 
risk).
 
These
 
clusters
 
highlight
 
distinct
 
behavioral
 
patterns
 
among
 
employees,
 
aiding
 
targeted
 
interventions.
 


 
 
 
 
 
 
Logistic
 
Regression
 
Model
 
 
 
 
 


 
 
 
Accuracy
:
 
The
 
model
 
achieved
 
an
 
accuracy
 
of
 
0.8
 
(80%),
 
indicating
 
a
 
reasonably
 
good
 
performance
 
in
 
predicting
 
employee
 
turnover.
 
Distribution
 
of
 
Predicted
 
Probabilities
:
 
●
 
The
 
pink
 
histogram
 
(Actual
 
Class
 
=
 
0)
 
represents
 
employees
 
who
 
stayed.
 
Most
 
probabilities
 
for
 
this
 
group
 
are
 
concentrated
 
towards
 
the
 
lower
 
range
 
(0.0–0.3),
 
showing
 
that
 
the
 
model
 
correctly
 
predicts
 
them
 
as
 
likely
 
to
 
stay.
 
●
 
The
 
blue
 
histogram
 
(Actual
 
Class
 
=
 
1)
 
represents
 
employees
 
who
 
left.
 
These
 
probabilities
 
are
 
more
 
spread
 
out
 
but
 
peak
 
around
 
the
 
higher
 
probability
 
range
 
(0.6–1.0),
 
showing
 
the
 
model
 
identifies
 
some
 
leavers
 
well.
 
Overlap
:
 
There
 
is
 
some
 
overlap
 
between
 
the
 
two
 
classes
 
in
 
the
 
range
 
of
 
0.3–0.6
,
 
indicating
 
ambiguity
 
in
 
prediction.
 
This
 
could
 
lead
 
to
 
false
 
positives
 
(predicting
 
an
 
employee
 
will
 
leave
 
when
 
they
 
stay)
 
or
 
false
 
negatives
 
(predicting
 
an
 
employee
 
will
 
stay
 
when
 
they
 
leave).
 
Insights
:
 
●
 
Employees
 
with
 
predicted
 
probabilities
 
closer
 
to
 
0
 
are
 
predominantly
 
stayers
 
(Class
 
0).
 
●
 
Employees
 
with
 
predicted
 
probabilities
 
closer
 
to
 
1
 
are
 
predominantly
 
leavers
 
(Class
 
1).
 
●
 
The
 
model's
 
ability
 
to
 
classify
 
is
 
more
 
accurate
 
at
 
the
 
extremes
 
(near
 
0
 
or
 
1)
 
but
 
less
 
certain
 
in
 
the
 
middle
 
range.
 
 
Sude
 
Nur
 
Ertürk
       
120200039
 
