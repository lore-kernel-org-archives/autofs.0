From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Tue, 22 Jul 2008 06:45:20 +0800
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F05192E8D@permls05.wde.woodside.com.au>
References: <1216625133.3093.23.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1216625133.3093.23.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian

Definitely happy to test patches but it how will we know if its
succesful?

CC 

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Monday, 21 July 2008 3:26 PM
> To: Coe, Colin C. (Unix Engineer)
> Cc: autofs@linux.kernel.org
> Subject: RE: [autofs] Autofs doesn't look at second LDAP server
> 
> 
> On Mon, 2008-07-21 at 15:18 +0800, Coe, Colin C. (Unix 
> Engineer) wrote:
> > It's not predictable.  But each machine that has failed has 
> had aether as it's primary LDAP server rather than aer.
> >  
> > We can go weeks without seeing the problem and then have 
> several machines effected within a few days.
> >  
> > We usually only see one machine fail a day but we only have 
> a handful of EL5 machines (EL5 is affected only that I can see).
> 
> >From the gdb trace it looks like the lookup context is 
> getting clobbered
> but I can't see any way that can happen.
> 
> But I do see that I don't have any locking on the servers 
> list which I'm
> still trying to understand how I could have possibly done. 
> That's really
> dumb.
> 
> So maybe the servers list is becoming corrupt sometime before the HUP
> signal. I can sent a patch to add that locking if your 
> willing test it.
> 
> >  
> > CC
> > 
> > ________________________________
> > 
> > From: Ian Kent [mailto:raven@themaw.net]
> > Sent: Mon 7/21/2008 12:30 PM
> > To: Coe, Colin C. (Unix Engineer)
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] Autofs doesn't look at second LDAP server
> > 
> > 
> > 
> > 
> > On Wed, 2008-07-16 at 09:20 +0800, Coe, Colin C. (Unix 
> Engineer) wrote:
> > > Hi all
> > >
> > > I've noticed that, after a period of stability, autofs is 
> dumping core
> > > again.
> > >
> > > The common thread is the time the core dumping happens, 
> 4AM (give or
> > > take a few minutes) which is when our 'cron daily' 
> process runs.  This
> > > 'cron daily' lives on an NFS mount that is in the auto_global map
> > > ('/nfs/appl server:/vol/oldserver_appl').
> > 
> > Are you able to duplicate this?
> > IOW, does it happen predicatably?
> > 
> > Ian
> > 
> > 
> > 
> > 
> > 
> > NOTICE: This email and any attachments are confidential. 
> > They may contain legally privileged information or 
> > copyright material. You must not read, copy, use or 
> > disclose them without authorisation. If you are not an 
> > intended recipient, please contact us at once by return 
> > email and then delete both messages and all attachments.
> > 
> 
> 

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
