From: Ian Kent <raven@themaw.net>
Subject: Re: module development
Date: Wed, 28 Feb 2007 11:00:50 +0900
Message-ID: <1172628050.3461.0.camel@raven.themaw.net>
References: <45E4AC36.3060707@cesca.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45E4AC36.3060707@cesca.es>
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
To: Jordi Prats <jprats@cesca.es>
Cc: autofs@linux.kernel.org

On Tue, 2007-02-27 at 23:09 +0100, Jordi Prats wrote:
> Hi all,
> I'm new to this list. I need to develop a module for autofs for a custom
> fs type, but I'm not really familiar with autofs. I'm supposing to do
> this I need to do a module like modules/mount_generic.c but with my
> custom stuff. For the mounting process it's all right, but to umount the
> fs I also need to do some operations.
> 
> There isn't any hook to do my custom operations before or after (in my
> cas doesn't matter) umounting it?
> 
> I'm sorry if this a simple or trivial question, but I didn't found how
> to do this as a module.

Your right, at this stage there isn't an entry point for the umount
operation.

Ian
