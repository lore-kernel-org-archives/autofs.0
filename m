From: "adelphia user" <sendtoadelphia@hotmail.com>
Subject: autofs-4.1.3-47 issue
Date: Sat, 05 Feb 2005 01:19:21 +0530
Message-ID: <BAY18-F29AEA825862ECF98A40C80D4700@phx.gbl>
Mime-Version: 1.0
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
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi all,

I have a question regarding the new version of autofs, specifically on 
"nosymlink".

    } else if (!nosymlink) {
        local = get_best_mount(whatstr, what, 0, 0);
        if (!*whatstr) {
            warn(MODPREFIX "no  host elected");
            return 1;
        }
        warn(MODPREFIX "from %s elected %s", what, whatstr);
    }

If  "nosymlink" is not used get_best_mount tries to use a rpc nfsv2 ping via 
rpc_time,  so if the NFS server does not support  NFSV2, it does not seem to 
try using a NFSV3  ping and just bails out. Because of this i am not able to 
use autofs with a server which supports only NFSv3 unless i use "nosymlink" 
as the option.  Will this be fixed so that the linux autofs will also try to 
  do a NFSv3 ping in case NFSv2 ping fails??

Any help is muchly appreciated
Thx,
Satya

_________________________________________________________________
The real power of teamwork. Experience it in real time. 
http://www.microsoft.com/india/office/experience/  Experience MS Office 
System.
