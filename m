From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 15:58:07 -0400
Message-ID: <16997.25295.980046.503116@segfault.boston.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com>
	<16997.22261.125769.972792@segfault.boston.redhat.com>
	<1113940219.1274.70.camel@barsoom.rdu.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113940219.1274.70.camel@barsoom.rdu.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org, raven@themaw.net

==> Regarding Re: [autofs] replicated mounts patch; Jeffrey Layton <jtlayton@poochiereds.net> adds:

>> From the docs:
>> 
>> The numbers in parentheses() indicate a weighting. Servers without a
>> weighting have a value of zero (most likely to be selected). The higher
>> the weighting value, the less chance the server will be selected.
>> 
>> Please change accordingly.
>> 
>> -Jeff
>> 

jtlayton> Simple enough to change, but where did you get the above info? I
jtlayton> couldn't find that in any of the manpages or README's. Also, the
jtlayton> README.replicated_mounts file seems to indicate the opposite:

http://docs.sun.com/app/docs/doc/801-6634/6i10efsl2?q=automount&a=view

Look for this section:

  How Autofs Selects the Nearest Read-Only Files for Clients (Multiple
  Locations)

Or from the Solaris man page, if you prefer:

http://docs.sun.com/app/docs/doc/816-0211/6m6nc66nc?a=view

  "Requests for a server may be weighted, with the weighting factor appended
   to the server name as an integer in parentheses. Servers without a
   weighting are assumed to have a value of zero (most likely to be selected)."

If the documentation for the Linux automounter conflicts with that of Sun,
I would say it is a bug.  Let's fix it.

-Jeff
