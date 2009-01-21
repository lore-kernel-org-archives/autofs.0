From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Wed, 21 Jan 2009 14:29:43 +0900
Message-ID: <1232515783.3931.28.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Wed, 2009-01-21 at 16:15 +1100, Paul Wankadia wrote:
> On Wed, Jan 21, 2009 at 2:49 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         Fortunately, these cases usually don't happen so we haven't
>         seen a
>         problem with it already.
>         
>         Anyway, i think this is all we need although continuing after
>         an malloc
>         fail is a bit questionable. Suggestions?
> 
> In this case, make_fullpath() is called from only one place and its
> return value is checked, but I was asking in general, yes.

Not sure I understand the question.

Functions like make_fullpath() need to return a NULL in such a case
because it has to be up to the caller to decide on how to handle the
fail.

In the case above it is questionable whether we continue the prune but
then another thread could free() heap memory so we might still be able
to make some useful progress.

Ian
