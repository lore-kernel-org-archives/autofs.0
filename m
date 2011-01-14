From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in follow_automount(), not ->d_automount()
Date: Fri, 14 Jan 2011 17:30:49 +0000
Message-ID: <6759.1295026249@redhat.com>
References: <6672.1295025969@redhat.com> <20110114154652.GD19804@ZenIV.linux.org.uk> <20110114070224.GB19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk> <2443.1295005428@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <6672.1295025969@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> This would mean the currently upstream code is buggy for AFS, CIFS and NFS.

Actually, no it wouldn't, since do_add_mount() is what adds the mount to the
expiration list.

David
