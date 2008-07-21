From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Mon, 21 Jul 2008 15:18:22 +0800
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F05AD77CD@permls05.wde.woodside.com.au>
References: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
	<1216614624.3093.0.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

It's not predictable.  But each machine that has failed has had aether as it's primary LDAP server rather than aer.
 
We can go weeks without seeing the problem and then have several machines effected within a few days.
 
We usually only see one machine fail a day but we only have a handful of EL5 machines (EL5 is affected only that I can see).
 
CC

________________________________

From: Ian Kent [mailto:raven@themaw.net]
Sent: Mon 7/21/2008 12:30 PM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Autofs doesn't look at second LDAP server




On Wed, 2008-07-16 at 09:20 +0800, Coe, Colin C. (Unix Engineer) wrote:
> Hi all
>
> I've noticed that, after a period of stability, autofs is dumping core
> again.
>
> The common thread is the time the core dumping happens, 4AM (give or
> take a few minutes) which is when our 'cron daily' process runs.  This
> 'cron daily' lives on an NFS mount that is in the auto_global map
> ('/nfs/appl server:/vol/oldserver_appl').

Are you able to duplicate this?
IOW, does it happen predicatably?

Ian





NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
