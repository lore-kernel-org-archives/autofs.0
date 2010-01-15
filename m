From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super block info
Date: Fri, 15 Jan 2010 17:08:28 +0000
Message-ID: <9927.1263575308@redhat.com>
References: <20100115165814.GL19799@ZenIV.linux.org.uk> <20100115080323.GK19799@ZenIV.linux.org.uk> <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100115165814.GL19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, Ian Kent <raven@themaw.net>, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> Do you want it to inerit e.g. nosuid?

Are you just talking about MNT_SHRINKABLE?  Or all the other flags?

Should I be passing:

	nd->path.mnt->mnt_flags | MNT_SHRINKABLE

instead?

David
