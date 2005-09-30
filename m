From: Jim Carter <jimc@math.ucla.edu>
Subject: RE: Autofs LDAP info
Date: Fri, 30 Sep 2005 12:12:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0509301204450.12370@simba.math.ucla.edu>
References: <01C21895FD36D7419A4777E29FED91B90151DA84@houmbx19.anadarko.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <01C21895FD36D7419A4777E29FED91B90151DA84@houmbx19.anadarko.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Wolfe, Allan" <Allan_Wolfe@anadarko.com>
Cc: autofs@linux.kernel.org

On Fri, 30 Sep 2005, Wolfe, Allan wrote:
> (1) How does one utilize ldaps. All the notes I've seen has been
> insecure transport.  We can't justify GSSAPI and TLS simple fits our
> needs. 

I'm following this thread with interest because I want to dump NIS and 
switch all the tables to LDAP, specifically autofs maps.  I'm just starting 
out here, but it looks to me like you specify in /etc/ldap.conf "URI 
ldaps:/server.example.com" (assuming the name can be resolved by DNS 
without using a host map in LDAP :-), or use a numeric IP address.

This would use TLS for every LDAP lookup, which is overkill.  It wasn't 
immediately obvious how to use one URI (no TLS) for one set of maps and the 
TLS URI for others where it makes a difference.  I'm sure I'll be able to 
figure it out.  In my environment, encryption is not useful for the autofs 
maps.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
