From: mmarion@qualcomm.com
Subject: Re: unacceptable bug in autofs kernel module
Date: Thu, 3 Feb 2005 16:38:46 -0800 (PST)
Message-ID: <200502040038.j140ck99006468@cornholio.qualcomm.com>
References: <41D1106C.9070706@intraperson.com>
Mime-Version: 1.0
In-Reply-To: <41D1106C.9070706@intraperson.com>
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
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ramana@intraperson.com
Cc: autofs@linux.kernel.org

On 28 Dec, ramana wrote:

> Here is the bug in autofs3 module which causing so much pain. It simply 
> stopped me from adding much more interesting features to Autodir 
> http://www.intraperson.com/autodir/
[snip]
> Because of this, user space test program reporting like this:
> 
> fail : /test/t944 : No such file or directory
> fail : /test/t4187 : No such file or directory

Hmm.. I wonder if this might be related to a weirdness we're seeing. Running
autofs-4.1.3 with previous latest patch to kernel (pre-2005 release) and users
use LSF to submit batch jobs to hosts.  On linux hosts, user level programs
will sometimes exit quickly with a "file does not exist" error, even though you
can login to the host and see the file/dir just fine.  As a hacked
work-around, we have a pre-exec script that tries to stat all the directories
they need to force the mounts to happen before their program touches the
files.

I didn't see any attempts to patch this bit.. did you have any ideas on how to
patch that particular piece of code?   Or just comment it out?

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Groundskeeper Willie: "oooh.. Me mule wouldn't walk in the mud.  So I had to 
put 17 bullets in 'em." ==> Simpsons
