From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: How does autofs know when the maps have changed?
Date: Wed, 2 Jan 2008 11:05:19 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929A1@permls05.wde.woodside.com.au>
References: <1199238690.3072.6.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1199238690.3072.6.camel@raven.themaw.net>
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

Thanks for this :)

At the behest of one of the data admins, I scheduled a '/sbin/service
autofs reload' at 8AM, 12PM, 3PM and 6PM.  In addition to this, there is
a nightly autofs reload.  The day after putting in the addition reloads,
most of our EL3 boxes had stale mounts.  Stopping the autofs reloads
during the day stopped the stale mounts occuring.  Do you have any
recommendations for scheduling regular autofs updates?  

Something like DNS style serial numbers would be nice to be able to
query the clients to make sure their maps are up to date.  Yep, I
realise this is next to impossible to implement and maintain
compatibility with the rest of the world...

CC

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Wednesday, 2 January 2008 9:51 AM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] How does autofs know when the maps have changed?

On Wed, 2008-01-02 at 07:12 +0900, Coe, Colin C. (Unix Engineer) wrote:
> Hi all
> 
> We have a mix of Linux and Solaris workstations and servers.  In
Solaris
> land, an 'automount -v' is run nightly to pickup any changes to the
> automount maps.  Is this required with the autofs distributed by
RedHat?
> Does autofs do any checking to see if the map has changed? We're
running
> RedHat EL 3, 4 and 5, (mostly) fully patched.

Basically, yes and no!

There are some differences between version 4 and version 5 but below is
generally the case.

For indirect maps it should see changes but a HUP signal can be used to
force an update.

For direct maps you need to send a HUP signal to the daemon.

A "service autofs reload" will do this. But be aware that RHEL 5.1 has a
bug that can cause it to wipe out the map under some circumstances.

Ian

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
