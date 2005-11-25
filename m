From: thorild@Update.UU.SE (Thorild Selen)
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Fri, 25 Nov 2005 19:01:51 +0100
Message-ID: <17287.20879.104271.43152@Psilocybe.Update.UU.SE>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
	<Pine.LNX.4.63.0511231359220.20045@simba.math.ucla.edu>
	<x3kiruhbkzh.fsf@Psilocybe.Update.UU.SE>
	<Pine.LNX.4.58.0511251021100.3517@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511251021100.3517@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Thorild Selen <thorild@Update.UU.SE>

Ian Kent writes:
 > But, at this stage, autofs isn't going to be listening it's going to b=
e=20
 > asking?

LCUP provides a syncOnly mode if you don't want to listen persistently
but instead occasionally ask for changes. If I've understood it
correctly, it would work basically like this:

 1. The automounter downloads a table from the LDAP server, attaching
    a Sync Request control (with no synchronisation cookie) to the
    search request.

 2. The LDAP server returns the table, together with a synchronisation
    cookie.

 3. Later, the automounter may ask the server: "What changes have been
    made to this table since you handed out this synchronisation
    cookie?" (Yes, I know, there is no such thing as a table from the
    LDAP server's point of view, but you get the point.) The server
    will then tell the client about any changes since then, including
    added/deleted entries, and return a new synchronisation cookie to
    be used in the next sync request. Repeat each time we want to
    check for modifications.

    NOTE: I believe the server is not required to keep this
    synchronisation state around. The server may refuse, in which case
    we go back to 1. and download the table from scratch.


The advantage with this would be that the automounter can keep its
tables perfectly up to date without having to retrieve the tables in
their entirety over and over again.

(Alternatively, LCUP has a persistent mode where you constantly listen
for changes instead of requesting them when required. That would
probably not scale as well as using the syncOnly mode.)


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
