From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs_home map
Date: Fri, 16 Nov 2007 15:43:41 +0900
Message-ID: <1195195421.3131.41.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE737@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F041EE737@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Thu, 2007-11-08 at 13:27 +0900, Coe, Colin C. (Unix Engineer) wrote:
> [root@las004 images]# cat /etc/auto.master
> /-      autofs.global --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> /rhome  autofs.home   --ghost nfsvers=3,tcp,rsize=32768,wsize=32768
> --debug

I'm a little rusty on our enhancements for RHEL autofs v4 so I'm much
more comfortable working with v5 and Jeff is really busy so we should
work this through using v5.

How about posting you're auto.master from LDAP, if you have one.

But, as far as version 5 is concerned, the above map will never be read
if there is an LDAP auto.master as only one master map is allowed and
plus map inclusion is only valid in file based maps. So, normally we
would just stick "+auto.master" in /etc/auto.master to get an additional
master map from the external service. Also, this order ensures that the
file map entries will override subsequent external service map entries,
since the first encountered entry is used and following entries for the
same mount point are ignored. The exception, of course, is direct mount
entries in the master map which are merged from all listed sources and
the first encountered map entry for each is used if there are duplicates
(at least I think, may need to check that).

So lets continue with autofs5 and sort out that SEGV (that's an
unpleasant and unexpected surprise for me) first and then we'll continue
with this.

Ian
