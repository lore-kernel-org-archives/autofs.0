From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5 not recognizing manual umounts properly
Date: Mon, 30 Oct 2006 17:19:27 +0800
Message-ID: <1162199967.2900.15.camel@localhost>
References: <B2E30F3E-200F-4D99-8813-732B62601D43@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <B2E30F3E-200F-4D99-8813-732B62601D43@online.de>
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
To: Timo Wendt <twendt@online.de>
Cc: autofs@linux.kernel.org

On Sat, 2006-10-28 at 18:41 +0200, Timo Wendt wrote:
> Hi,
> 
> 
> I have just installed FC6 to do some tests with autofs 5 as I need to
> use direct mounts. The new version works really great. The only thing
> I figured out so far that does not work fine is, when I umount one of
> the automounted fs manually.
> If I then try to list the contents of that directory it says, that it
> is empty. As soon as I try to create a file in that directory, it
> fails and seems to realize, that the directory should be mounted and
> remounts it, without creating the file though.

And what kernel are you using?
And the version of autofs?

Ian
