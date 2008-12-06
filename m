From: Ian Kent <raven@themaw.net>
Subject: Re: ldap syntax issue in 5.0.3 ?
Date: Sat, 06 Dec 2008 12:18:01 +0900
Message-ID: <1228533481.3033.21.camel@zeus.themaw.net>
References: <49396DF1.7060902@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49396DF1.7060902@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 19:07 +0100, Guillaume Rousse wrote:
> According to https://qa.mandriva.com/show_bug.cgi?id=45984, the old 
> ldap:servername:mapname syntax, documented in auto.master man page, 
> doesn't work correctly in the autofs package shipped in mandriva 2009 
> (5.0.3 + all official patches until 
> autofs-5.0.3-fix-couple-of-memory-leaks.patch applied).

The report doesn't look like a problem with the above syntax.

The report is unclear as to what is being done.
What is the difference between the first run and the second run. That's
not clear at all.

The trailing slash on the key is not good. There is a patch to fix
master map parsing where a map type is included in the map name prior to
the patch mentioned above. Detecting a path with a trailing "/" may have
been an unexpected side effect of that. The trailing slash should not be
present and I recommend that it not be used in maps.

Does this map function ok without the trailing slash?

Ian
