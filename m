From: Ian Kent <raven@themaw.net>
Subject: Re: Issues with failed bind mounts in autofs 5.0.5
Date: Mon, 25 Jan 2010 11:55:17 +0800
Message-ID: <4B5D1625.3010000@themaw.net>
References: <1264190553.23526.148.camel@psmith-ubeta.netezza.com>
	<1264206346-sup-8713@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1264206346-sup-8713@nixos>
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
To: autofs@linux.kernel.org

On 01/23/2010 08:27 AM, Marc Weber wrote:
> Excerpts from Paul Smith's message of Fri Jan 22 21:02:33 +0100 2010:
>> I couldn't find any reference to how to access autofs latest source (is
>> it available in git or CVS or somewhere? 
> http://ftp.riken.go.jp/Linux/kernel.org/scm/linux/storage/autofs/autofs.git
> 
> I don't remember how I found it. Last change is
> Date:   Tue Mar 17 11:43:40 2009 +0900

That's got to be out of date.

The official location is on kernel.org at:

git.kernel.org/pub/scm/linux/storage/autofs/autofs.git

I believe that http should work OK as well as the usual git access
method. So

git clone git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git

should get you want you need.

And of course you can inspect the repo using the git web interface on
kernel.org at:

http://git.kernel.org/?p=linux/storage/autofs/autofs.git;a=summary

> 
> So I'm not totally sure wether this is still the correct location. But I
> think not much has changed.

No, that must be an out of date mirror of kernel.org.

> 
> So yes: there should be a wiki!
> 
> I'm still willing to spend some minimal time on putting useful online..

Yes, a wiki would be good.

The truth is that I'm well and truly over creating and administering web
sites so, even if we did have a place to host it, anything we do will
need to be a group effort. Clearly, I would be happy to review,
contribute and share (to a reasonable extent) administration.

I'm fairly confident that if we requested a wiki for autofs on
kernel.org that would be approved. I haven't looked into what that would
mean wrt. to administration and also if it is possible for people
without kernel.org accounts to carry out the administration and editing.
Mainly because I didn't think we had a sufficient number of people
interested in contributing time and effort.

Ian
