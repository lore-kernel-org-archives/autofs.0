From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: making the mountpoints visible all the time
Date: Tue, 18 Nov 2003 16:24:05 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1069201444.28347.12.camel@ugly>
References: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, 2003-11-13 at 19:04, Ian Kent wrote:
> On Thu, 13 Nov 2003, Taylor, ForrestX wrote:
> 
> > Alexander Macdonald wrote:
> > > Hi
> > >
> > > I've currently got automount setup so that i can cd into a directory
> > > like /mnt/someplace and someplace will be automatically created and
> > > mounted... it would be quite usefull if that directory was allways
> > > visible so that i could browse to it in gui applications... how do i do
> > > that?
> >
> > If you want it visible all the time, use /etc/fstab, not autofs.  Work
> > is being done on leaving the directory structure before actually
> > mounting it, but it is not finished yet.
> >
> 
> Umm ...
> 
> Beg to disagree.
> 
> The autofs4-2.4 module build kit or the patches contained in it or the
> patches contained in autofs-4.1.0-beta3 can give you this for some of the
> maps. NIS, LDAP and file maps work at the moment.
> 
> I's in the expected place on kernel.org.

Now it is my turn to apologize.  I saw the autofs module on the ftp
site, but I didn't have time to investigate.  Has this module been
included in the upstream kernel yet?

Forrest
-- 
