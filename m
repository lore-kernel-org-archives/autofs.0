From: Ian Kent <raven@themaw.net>
Subject: Re: problems in daemon/lookup.c
Date: Fri, 23 Jan 2009 14:36:33 +0900
Message-ID: <1232688993.3011.30.camel@zeus.themaw.net>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
	<1232604292.3239.17.camel@zeus.themaw.net>
	<408431290901221800y3c008d5dib66b2786e832c086@mail.gmail.com>
	<1232683724.3011.6.camel@zeus.themaw.net>
	<408431290901222127n3d8a759eka7151cb60f6a8e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901222127n3d8a759eka7151cb60f6a8e13@mail.gmail.com>
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

On Fri, 2009-01-23 at 16:27 +1100, Paul Wankadia wrote:
> On Fri, Jan 23, 2009 at 3:08 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         at this point either list == ent or ent is linked into list.
> ...
> 
>         So in all these cases it looks to me like free_mnt_list()
>         handles the
>         dealloc.
> 
> Oh, I see. Thanks.
> 
> 
>         > Also, strdup(3) is useful. :P
>         
>         
>         Sure, but not this time around, ;)
> 
> Hmm?

Well maybe, ;)
