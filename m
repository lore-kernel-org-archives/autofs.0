From: Ian Kent <raven@themaw.net>
Subject: Re: About reading events from /dev/autofs
Date: Tue, 20 Apr 2010 18:53:51 +0800
Message-ID: <1271760831.16887.0.camel@localhost>
References: <4BCD778A.7070707@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=HHqIPKf7JVjNMimkT3wrRto2/DE=;
	b=HUnlHuVhDM/1SorD1iboUGic7BOuq07yIMl/u+QvN6yyysecHUGYLKeXo08Nw+5ex4vY6jETfzyHYWBDb1K6mUeeV84LzTMWlVkyGbgq+XjiOdM7KSO0STEhlXsKi0uA9W+EpwkV97AZJT87RyE4o0QodfHZlmFWW7it+TZJMK8=
In-Reply-To: <4BCD778A.7070707@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Tue, 2010-04-20 at 11:44 +0200, Stef Bon wrote:
> Hello,
> 
> earlier I've written a testprog to read /dev/autofs. It did not work:
> 
> http://linux.kernel.org/pipermail/autofs/2010-March/006071.html
> 
> Is there a way to watch /dev/autofs (with select or epoll) from within my C
> program?

No, it's a control device only.

Ian
