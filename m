From: ramana <intraperson@yahoo.com>
Subject: Re: Large number of mount request.
Date: Fri, 23 Jun 2006 04:27:41 -0700 (PDT)
Message-ID: <20060623112741.95825.qmail@web34505.mail.mud.yahoo.com>
References: <01e801c68f82$3794d8e0$6cf1718c@administrator>
Reply-To: ramana@intraperson.com
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <01e801c68f82$3794d8e0$6cf1718c@administrator>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Latrell <is85022@cis.nctu.edu.tw>, autofs@linux.kernel.org

--- Latrell <is85022@cis.nctu.edu.tw> wrote:

> Hi, all:
> 
> I have a problem with the mount and umount packet.
> My problem is when I have a large number of mount requests, some
> mount request packets are missing. Thus, when I "cd share1", I will
> get "fail to change directory" because share1 is not mounted. Fewer
> mount requests work normally. 

I am afraid, this is ENOENT bug.

Thanks in advance.

Regards
ramana

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
