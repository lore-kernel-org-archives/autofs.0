From: mmarion@qualcomm.com
Subject: Re: Strange autofs V4.0 problems
Date: Tue, 3 Feb 2004 14:07:40 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200402032207.i13M7e3K000813@miguelito.qualcomm.com>
References: <200402030059.i130xG3K028336@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200402030059.i130xG3K028336@miguelito.qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  2 Feb, To: mlblandf@sedona.ch.intel.com wrote:

>> If you can mount them by hand on the same box not using autofs, then it 
>> seems more likely to be an autofs issue.
> 
> Tried that.. can't.  Going to have our netapp people look into it as other
> netaps are fine.
> 

We finally figured out that our netgroup.byname map was being truncated... and
that's why smoe hosts weren't mounting when others could.  

We added a ton of entries into our duty system, that expand out to netgroups
on each host, so we went beyond the length a single entry can have.  They're
working on truncating the lists into sub-netgroups like we had to do years ago
for some of the other netgroup maps.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"Administering a Linux server is no more difficult than properly running
Windows NT."
  -- Infoworld, November 24, 1997
