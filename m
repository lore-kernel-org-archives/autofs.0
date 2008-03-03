From: Massimo Mongardini <massimo@mongardini.it>
Subject: Re: simple automount question
Date: Mon, 03 Mar 2008 10:08:11 +0000
Message-ID: <47CBCE0B.3040204@mongardini.it>
References: <1204517826.5312.62.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204517826.5312.62.camel@localhost>
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

Chris,
    if I understood your question right, you just want the folders to be 
fisible. If that's the case  you could try the -g (--ghost) option of 
automount.

cheers
Massimo

chris barry wrote:
> I've googled, but have not found an answer to this seemingly simple
> question.
>
> I'm automounting /foo from box1 on box2. /foo has no files, just other
> directories, one of which is bar.
>
> box2 $ cd /foo
> box2 $ ls
> box2 $ (nothing shows up)
> box2 $ cd bar
> box2 $ cd ..
> box2 $ ls
> bar
> box2 $
>
>
> Q: how do I get all of the directories under /foo to show up after it's
> automounted?
>
> /etc/auto.master
> /foo	/etc/auto.foo --timeout=60
>
> /etc/auto.foo
> (all on one line)
> *              /
> -fstype=nfs,rsize=32768,wsize=32768,tcp,rw,bg,hard,intr,noacl,nocto,async   10.20.30.40:/foo/&
>
> Is my auto.foo wrong for this application?
>
>
> Thanks,
> -C
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   


-- 
Massimo Mongardini

_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_


echo 'Jg!J!hjwf!zpv!bo!bqqmf!boe!zpv!hjwf!nf!bo!bqqmf-!uifo!xf!xjmm!ibwf!bo!bqqmf!fbdi/!Cvu!jg!J!hjwf!zpv!bo!jefb!boe!zpv!hjwf!nf!bo!jefb-!xf!xjmm!ibwf!uxp!jefbt!fbdi!' | perl -pe 's/(.)/chr(ord($1)-1)/ge'


#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
