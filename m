From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: backfstype patch.
Date: Fri, 16 Jul 2004 15:01:03 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16632.9711.453411.560590@segfault.boston.redhat.com>
References: <40F82248.2050803@deragon.biz>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40F82248.2050803@deragon.biz>
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
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] backfstype patch.; Hans Deragon <hans@deragon.biz> adds:

hans> Greetings.  Remember me with my backfstype patch?  Some people
hans> commented on it, I replied and then never got any answers since.
hans> Altough functional, my patch was questionned; the fix was not at the
hans> right place within the code (from a design/elegance point of view;
hans> technically it works great).  As I explained, I have no knowledge of
hans> the overall architecture of Autofs and unfortunatly, I do not have
hans> the time to get deep into it.

hans>    Can my patch still be applied in the main branch until it is moved
hans> into a more appropriate area of the code?  Its still adds the new
hans> backsftype support, does not cause any problems, is very localized,
hans> and very usefull.  I have been running it since the last 2 weeks
hans> without any problems.  I am rolling it out in the production
hans> environment.

Ultimately, this is up to Ian.  I have a todo list item to implement a
cachefs mount module (which was the agreed upon correct approach).
Unfortunately, it's quite low on the todo list.  :(

-Jeff
