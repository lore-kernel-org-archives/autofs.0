From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: automounting other hosts on the network
Date: Tue, 09 Mar 2004 09:37:14 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1078853834.16233.18.camel@bad.jf.intel.com>
References: <404D8C3D.9000500@icemcfd.co.in>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <404D8C3D.9000500@icemcfd.co.in>
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
To: "Pranay C. Tembhekar" <pranay@icemcfd.co.in>
Cc: autofs@linux.kernel.org

On Tue, 2004-03-09 at 01:19, Pranay C. Tembhekar wrote:
> Hi Everybody,
>     I want little bit help. I've installed Red Hat Linux 8.0 & 
> configured it as a NFS & NIS server. I also installed Red Hat Linux 8.0 
> on other system as a NIS client. Now I want to automount the hosts. E.g. 
> /hosts/<systemname>/home. I have exported the /home from server. How can 
> I achieve this in red hat linux. In solaris I can specify "/hosts -hosts 
> <options" in auto_master. But what's the procedure to do this in red hat 
> linux?

Use autofs4 (ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/).  Grab
the latest src.rpm and rebuild it.  You will probably have to make
autofs start after NIS.  In the spec file, I have:
# chkconfig: 345 61 19

Also, make sure you have 'alias autofs autofs4' in /etc/modules.conf,
and remove the autofs3 module (service autofs stop;rmmod autofs).  I
usually put these in the RPM file, but I haven't downloaded the latest
to see if this is already in it.

Once you rebuild the src.rpm file, install it and start it.  Instead of
/hosts, you will use /net, and you may want to add nonstrict to the opts
line in /etc/auto.net (if it isn't already).

If you have problems, return with your errors.

Forrest
