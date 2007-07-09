From: Ian Kent <raven@themaw.net>
Subject: Re: autofs program user variable
Date: Mon, 09 Jul 2007 11:29:04 +0800
Message-ID: <1183951744.3538.4.camel@raven.themaw.net>
References: <812495870706282031p666550d2j15fd361e5899de9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <812495870706282031p666550d2j15fd361e5899de9a@mail.gmail.com>
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
To: William Prochazka <billprozac@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-06-28 at 23:31 -0400, William Prochazka wrote:

Hi,

> Hi, I am sort of new to autofs, but love it as it is truly great.
> We currently do all of our automounts through LDAP (works great), but
> I would love to do some programmatic mounts (improvements to the
> auto.smb script that is distributed with FC6).  I have made a number
> of improvements, but I would really like to know if there is a way of
> determining the user that is attempting to traverse into the then
> automounted directory.  I have some methods of guessing the info, but
> they are just guesses.  Since the script is run by the service, $USER
> is worthless.  Any help would be much appreciated.  Thanks and great
> work! 

This was a problem with with version 4 as that information wasn't
recorded in the request that came from the kernel and so it couldn't be
done.

In version 5 the kernel module sends uid as well and it is used to set
several environment variables, $USER is one.

Ian
