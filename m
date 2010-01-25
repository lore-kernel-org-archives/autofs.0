From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in
 super block info
Date: Mon, 25 Jan 2010 00:16:10 -0800
Message-ID: <4B5D534A.4040202@zytor.com>
References: <20100114191847.GD24005@shell>
	<4B5005A4.7080508@themaw.net>	<4806.1263567323@redhat.com>
	<9927.1263575308@redhat.com>	<20100115172633.GM19799@ZenIV.linux.org.uk>	<20100116101714.GN19799@ZenIV.linux.org.uk>	<20100117175723.GP19799@ZenIV.linux.org.uk>	<4B53E1B5.2080202@themaw.net>	<20100118055929.GS19799@ZenIV.linux.org.uk>	<4B542692.2070307@themaw.net>	<20100118102732.GU19799@ZenIV.linux.org.uk>
	<1263843353.4127.33.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1263843353.4127.33.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On 01/18/2010 11:35 AM, Trond Myklebust wrote:
> On Mon, 2010-01-18 at 10:27 +0000, Al Viro wrote:
>> Back to another question: which syscalls should and which syscalls should not
>> trigger automount on the last component?  Note that it's something we'd better
>> be consistent about between autofs4 and cifs/afs/nfs...
>
> In addition to the ones that trigger automounts now:
>
> One syscall that we've had a lot of complaints about is 'stat()'. Since
> it doesn't follow symlinks, it will fail to trigger the automount, and
> will return bogus values for st_dev. This again confuses some versions
> of the 'du' utility that check the value of st_dev before and after
> entering the subdir.
> (see https://bugzilla.redhat.com/show_bug.cgi?id=431166 )
>

[Sorry for late comment]

I presume you mean lstat() here.  This is *exactly* the intended 
semantics -- this prevents a GUI from looking in /home with enumeration 
enabled, and mounting *every single subvolume* in that map.

Thus the semantic: "don't automount if you wouldn't follow a symlink". 
It's perhaps not *ideal*, but it is a pretty decent approximation, easy 
to describe, and serves the purpose.

	-hpa
