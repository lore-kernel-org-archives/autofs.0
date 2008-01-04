From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: How does autofs know when the maps have changed?
Date: Fri, 4 Jan 2008 12:13:33 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929AA@permls05.wde.woodside.com.au>
References: <1199255952.3072.20.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1199255952.3072.20.camel@raven.themaw.net>
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

RHEL3u9, autofs 4.1.3-216

CC 

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Wednesday, 2 January 2008 2:39 PM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: RE: [autofs] How does autofs know when the maps have changed?

On Wed, 2008-01-02 at 11:05 +0900, Coe, Colin C. (Unix Engineer) wrote:
> Hi Ian
> 
> Thanks for this :)
> 
> At the behest of one of the data admins, I scheduled a '/sbin/service
> autofs reload' at 8AM, 12PM, 3PM and 6PM.  In addition to this, there
is
> a nightly autofs reload.  The day after putting in the addition
reloads,
> most of our EL3 boxes had stale mounts.  Stopping the autofs reloads
> during the day stopped the stale mounts occuring.  Do you have any
> recommendations for scheduling regular autofs updates? 

EL3 is a bit old.
What version of autofs?
Maybe there's is an update available or maybe we need to build a later
version for your EL3 boxes.

>  
> 
> Something like DNS style serial numbers would be nice to be able to
> query the clients to make sure their maps are up to date.  Yep, I
> realise this is next to impossible to implement and maintain
> compatibility with the rest of the world...

The problem of recognizing whether a map needs an update has been around
for a long time and a lot of time has gone into making autofs aware of
updates to maps when they are present. We can't really add fields to
maps because that would make autofs different from other implementations
not to mention how difficult it would be to do for the various map
sources. Where a generation stamp is available, such as in NIS, it has
been used in later updates.

However, the stale mounts is likely a different problem.

Ian

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
