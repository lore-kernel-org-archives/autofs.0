From: Joe Pruett <joey@clean.q7.com>
Subject: Re: something changed from 4 to 5
Date: Tue, 2 Sep 2008 15:07:35 -0700 (PDT)
Message-ID: <alpine.LRH.1.10.0809021505160.3308@q7.q7.com>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218596289.3148.8.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

recap: automount gets hung waiting for something to happen and never times 
out so user processes get hung forever.  an strace or gdb of the automount 
processes will clear things up and then it runs fine for days.

of course the problem has not come back now that i have debugging enabled. 
that certainly makes it seem like a timing issue of some sort.  i'll keep 
it running this way and hope that we'll see something happen.
