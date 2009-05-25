From: Ian Kent <raven@themaw.net>
Subject: Re: Should stat(2)ing an automount mount point trigger the
 automount?
Date: Mon, 25 May 2009 13:11:38 +0800
Message-ID: <4A1A288A.4030309@themaw.net>
References: <67349.32791243014169920.JavaMail.root@zimbra.solidstatescientific.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <67349.32791243014169920.JavaMail.root@zimbra.solidstatescientific.com>
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
To: Phil Dumont <phil@solidstatescientific.com>
Cc: autofs@linux.kernel.org

Phil Dumont wrote:
> On a CentOS 5.4 installation, I ran this command:

5.4?
How so?

> 
> find /net/fs/export/vtrak3b/keeper/
> 
> ...and it yielded this message to stderr:
> 
> find: WARNING: Hard link count is wrong for /net/fs/export/vtrak3b/keeper/: this may be a bug in your filesystem driver. Automatically turning on find's -noleaf option. Earlier results may have failed to include directories that should have been searched. 
> 
> Apparently, as soon as you access /net/host, if host is exporting
> any paths other than /, the automount daemon will create a mount
> point /net/host/path/to/export for every path exported by host,
> but doesn't actually mount anything until you read the
> exported/automounted directory.  (The host 'fs' is exporting
> /export/vtrak3b/keeper, along with some other non-root
> directories.)
> 
> And it would seem that stat(2)ing the mount point does not
> trigger the automount, so the stat(2) reports on the mount
> point, not the directory that's going to be mounted there.
> 
> It would seem that find stat(2)s a directory before it opendir(3)s
> it.  So the stat(2) of keeper saw a hard link count of 2 (which is
> correct for the empty mount point), but when find started reading the
> directory, that triggered the automount, and it was now accessing the
> mounted directory instead of the mount point, and apparently noticed
> the discrepancy.

That is exactly what happens, it is deliberate and it has been that way
for a long time.

autofs must not accurately honour stat(2) in certain cases because the
widespread use of colour ls leads to mount storms.

For example, if you have an indirect map that uses the "browse" option
then all the mount point directories will exist within the autofs
managed directory. If we honour stat(2), a colour ls on the autofs mount
point will then cause every mount within that directory to be mounted.
This is fine for small maps but, as you can imagine, maps with around a
100 or more entries start to become a problem and maps larger than this
are very common.

The specific case you mention, the hosts map, is essentially a multiple
mount map entry. Due to these potentially having a large number of
mounts we needed to make them mount and expire "on demand" rather than
mount and expire them all at once. This is done by mounting autofs mount
point triggers for each of the multiple mount locations and these have
the same semantics as maps that use the "browse" option so the issue is
present with them also. Note that mounting and umounting these
multi-mount entries as a single unit was seen to be a major problem with
autofs which is why it was changed.

The real problem is that we would like to be able to honour stat(2) in
some cases but not in others but we have no way of working out which is
which, at least that is my current belief. I haven't checked this for
some time now so maybe I should re-visit it.

Nevertheless, there will always be cases where we cannot honour stat(2)
or we cannot tell whether we should honour it.

Ian
