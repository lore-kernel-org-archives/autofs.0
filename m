From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 11:04:19 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
References: <3FB3E9B2.1090002@intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB3E9B2.1090002@intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Cc: autofs@linux.kernel.org

On Thu, 13 Nov 2003, Taylor, ForrestX wrote:

> Alexander Macdonald wrote:
> > Hi
> >
> > I've currently got automount setup so that i can cd into a directory
> > like /mnt/someplace and someplace will be automatically created and
> > mounted... it would be quite usefull if that directory was allways
> > visible so that i could browse to it in gui applications... how do i do
> > that?
>
> If you want it visible all the time, use /etc/fstab, not autofs.  Work
> is being done on leaving the directory structure before actually
> mounting it, but it is not finished yet.
>

Umm ...

Beg to disagree.

The autofs4-2.4 module build kit or the patches contained in it or the
patches contained in autofs-4.1.0-beta3 can give you this for some of the
maps. NIS, LDAP and file maps work at the moment.

I's in the expected place on kernel.org.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
