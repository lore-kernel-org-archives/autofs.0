From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Mon, 18 Jan 2010 13:08:12 +0800
Message-ID: <4B53ECBC.8030309@themaw.net>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <20100115080323.GK19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100115080323.GK19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, dhowells@redhat.com, Trond.Myklebust@netapp.com

On 01/15/2010 04:03 PM, Al Viro wrote:
> 	* what's going on with use of intent flags in case of autofs4?

It's the same old story.
autofs needs to take care not to trigger mounts for certain system calls
when we have reached the last path component. AFAIK the only way to do
that is to check the flags.

> 
> Other than that, it'd seem that we would be better off if we treated these
> guys as "if we try to follow mountpoint and that sucker turns out to be
> the end of the road, do something fs-specific and either try to go further
> or see if we could attach the mountpoint given to us here".  Which might
> be better done in VFS, with fs method returning vfsmount, NULL or ERR_PTR.

Forgive my thickness but am I understanding this correctly?

Are you just saying it would be better to add a file system method to
cater for the case where we might need to do further resolution on the
mount root we have just arrived at before continuing into it (mmm ...
now it feels like I've stated the obvious, but anyway ...)?

Would that be before following the link or after (not that it would
matter for my needs)?

Ian
