From: Oren Held <oren@held.org.il>
Subject: Re: auotfs v4
Date: Fri, 07 Nov 2003 00:57:47 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1068159466.10397.4.camel@localhost>
References: <3FAA8EE3.1060109@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FAA8EE3.1060109@rhythm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

Hi,

check your /proc/mounts file when it happens.
As you were already told it happens because of more than 256 nfs mounts
- but the question is wether you really have to mount that many (then
you have a problem, but there must be some patches to fix it) - or
whether it's an automounter problem.. I myself experienced such a thing
that tried to mount the same location many times till it filled the
whole mount table.

 - Oren

On Thu, 2003-11-06 at 20:11, Greg Bradner wrote:
> Any ideas what 'mount table full' means?
> Nov  6 10:08:44 linn automount[27555]: >> NFSv3 not supported!
> Nov  6 10:08:44 linn automount[27555]: >> mount table full
> Nov  6 10:08:44 linn automount[27555]: mount(nfs): nfs: mount failure 
> fs7:/vol/vol0/systems/celia/utils on /celia/utils/
> Nov  6 10:09:15 linn automount[1899]: attempting to mount entry 
> /misc/hsm_cache
> Nov  6 10:09:15 linn automount[27589]: >> NFSv3 not supported!
> Nov  6 10:09:15 linn automount[27589]: >> mount table full
> Nov  6 10:09:15 linn automount[27589]: mount(nfs): nfs: mount failure 
> fs8:/vol/vol0/hsm_cache on /misc/hsm_cache/
> 
> Everything works fine after a reboot.
