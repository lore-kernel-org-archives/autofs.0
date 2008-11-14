From: Ian Kent <raven@themaw.net>
Subject: Re: Caching negative lookups
Date: Fri, 14 Nov 2008 22:49:56 +0900
Message-ID: <1226670596.2906.40.camel@zeus.themaw.net>
References: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
	<1226628492.2906.15.camel@zeus.themaw.net>
	<e28c2a430811140527g7fbfb49aj652a1bfc4df3e5e1@mail.gmail.com>
	<1226670263.2906.38.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1226670263.2906.38.camel@zeus.themaw.net>
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
To: Mike K <mrkfact@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2008-11-14 at 22:44 +0900, Ian Kent wrote:
> On Fri, 2008-11-14 at 08:27 -0500, Mike K wrote:
> > Ian, 
> > 
> > Sorry for the confusion.  Yes, auto_dev is a simple indirect map.
> > Since it is a negative lookup, the entry we are looking up doesn't
> > exist in the auto_dev map, so I didn't bother showing any of its
> > contents.
> > 
> > So for some reason it appears that negative caching does not work for
> > the example I previous described since there is one lookup for every
> > "cd /home/dev/example", not one lookup for every negative timeout
> > seconds.
> 
> Provide a complete debug log showing the problem.
> See http://people.redhat.com/jmoyer for setup info.

No need.
I see what I've done wrong.
The cache ins't updated if the entry never existed.
Give some time to sort this out.

> 
> > 
> > - Mike
> > 
> > On Thu, Nov 13, 2008 at 9:08 PM, Ian Kent <raven@themaw.net> wrote:
> >         On Mon, 2008-11-03 at 10:03 -0500, Mike K wrote:
> >         > Hello,
> >         >
> >         > Based on what I have found, autofs5 supports caching
> >         negative lookups,
> >         > but it doesn't appear to be working for me.  Although my
> >         understanding
> >         > of how it is supposed to work is very limited, so I may just
> >         be
> >         > mistaken.
> >         >
> >         > My client system:  Red Hat 5.2,
> >         autofs-5.0.1-0.rc2.88.x86_64,
> >         > kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+
> >         server
> >         > (client in niscompat mode).
> >         > NFS Server: A popular NAS appliance
> >         >
> >         > auto_master snippet:
> >         > /home/dev auto_dev
> >         
> >         
> >         Is this meant to convey meaningful information?
> >         Is auto_dev a simple indirect map?
> >         
> >         >
> >         > By default (and a recommended setting), the NAS appliance
> >         requires
> >         > that all mounts from uid 0 come from a reserved port
> >         (0-1024) on the
> >         > client.  On our client system, repeated yp lookups for
> >         entries which
> >         > don't exist will consume all ports in 0-1024, causing other
> >         legit
> >         > mount attempts to fail since they are denied by the NAS
> >         appliance.
> >         > This does not happen on Red Hat 4 or 3 systems.
> >         >
> >         > Reproducer: 'while true; do cd /home/dev/example; done'.
> >          "watch -n 1
> >         > 'netstat -an | grep TIME_WAIT | wc -l'" will show the number
> >         of
> >         > sockets in TIME_WAIT increase rapidly.
> >         >
> >         > In this case, each 'cd /home/dev/example' causes a yp lookup
> >         for a
> >         > directory that doesn't exist in the NIS table, consuming a
> >         socket and
> >         > leaving it in TIME_WAIT for 60 seconds.
> >         >
> >         > Is this situation supposed to be prevented with caching
> >         negative
> >         > lookups?
> >         
> >         
> >         If auto_dev is a simple indirect map there should be one
> >         lookup every
> >         negative timeout seconds.
> >         
> >         >
> >         > Thanks,
> >         > Mike
> >         > _______________________________________________
> >         > autofs mailing list
> >         > autofs@linux.kernel.org
> >         > http://linux.kernel.org/mailman/listinfo/autofs
> >         
> > 
