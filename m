From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: consistent pathnames vs autofs
Date: Wed, 23 Feb 2005 12:09:38 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0502231142400.30588@simba.math.ucla.edu>
References: <200502192052.j1JKqiKs002944@calvin.labs.agilent.com>
Mime-Version: 1.0
In-Reply-To: <200502192052.j1JKqiKs002944@calvin.labs.agilent.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ken Poulton <poulton@calvin.labs.agilent.com>
Cc: autofs@linux.kernel.org

On Sat, 19 Feb 2005, Ken Poulton wrote:

> I'm trying to implement consistent global pathnames in Linux - that is,
> full pathnames to files are the same on all systems, including NFS
> clients and servers.  The problem is that autofs takes total ownership
> of the automounting directory, so it seems impossible to make the true
> file pathnames consistent between NFS servers and NFS clients. 

Here at UCLA-Mathnet our homedirs are of the form /net/tupelo/h1/maint/jimc 
(tupelo is the name of the server, and /h1 is what tupelo exports), and 
this path is valid both on random hosts, which NFS mount tupelo:/h1, and on 
tupelo itself (Linux kernel 2.4.20 or 2.6.8 depending on which server), 
where autofs does a bind mount from /net/tupelo/h1 to the local /h1. 
It's considered bad form to refer to /h1 explicitly in a script that may 
someday run on a different machine.

As a substitute for Sun's host map, we emit on the fly an indirect map
file with one line "*  tupelo:/&" whenever a new server is referred to in 
the /net directory.  Thus the client can mount anything that the server is 
willing to export, without having to enumerate that in advance.

Wouldn't it be nice if such a map file could be built up from macros within 
autofs, without needing to be instantiated as a file and periodically 
cleaned up?  So instead of doing (the internal equivalent of) 
    automount /net/tupelo file /tmp/tmpmaps/tupelo 
we would do
    automount /net/tupelo macro "* -rw,nodev,etc ${SERVER}:/&" \
							-DSERVER=tupelo


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
