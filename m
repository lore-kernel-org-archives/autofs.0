From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
	block info
Date: Fri, 15 Jan 2010 17:26:33 +0000
Message-ID: <20100115172633.GM19799@ZenIV.linux.org.uk>
References: <20100115165814.GL19799@ZenIV.linux.org.uk> <20100115080323.GK19799@ZenIV.linux.org.uk> <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9927.1263575308@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com

On Fri, Jan 15, 2010 at 05:08:28PM +0000, David Howells wrote:
> Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > Do you want it to inerit e.g. nosuid?
> 
> Are you just talking about MNT_SHRINKABLE?  Or all the other flags?
> 
> Should I be passing:
> 
> 	nd->path.mnt->mnt_flags | MNT_SHRINKABLE
> 
> instead?

Maybe, maybe not...  BTW, even that leaves an unpleasant race with
mnt_make_readonly() (CIFS and NFS seem to be suffering from one).
Which flags do we want to be inherited?  Grabbing MNT_WRITE_HOLD,
for example, would obviously be a bad idea...
