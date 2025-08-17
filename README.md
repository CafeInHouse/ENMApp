# ENMApp - iOS 이커머스 애플리케이션

## 프로젝트 개요

ENMApp은 Clean Architecture와 최신 iOS 개발 패턴을 적용한 이커머스 애플리케이션입니다. SwiftUI와 Tuist를 기반으로 모듈화된 구조를 통해 확장 가능하고 유지보수가 용이한 앱 아키텍처를 구현했습니다.

## 아키텍처 및 디자인 패턴

### Clean Architecture
본 프로젝트는 Clean Architecture 원칙에 따라 다음과 같은 계층으로 구성되어 있습니다:

```
┌─────────────────────────────────────────────────────┐
│                   Presentation Layer                │
│                  (Feature + Service)                │
│  - SwiftUI Views                                    │
│  - ViewModels (MVVM)                                │
│  - Coordinators                                     │
└─────────────────────────────────────────────────────┘
                           ▼
┌─────────────────────────────────────────────────────┐
│                     Domain Layer                    │
│  - Use Cases (Business Logic)                       │
│  - Repository Protocols                             │
│  - Domain Models                                    │
└─────────────────────────────────────────────────────┘
                           ▼
┌─────────────────────────────────────────────────────┐
│                      Data Layer                     │
│  - Repository Implementations                       │
│  - Data Sources                                     │
│  - Network Providers                                │
│  - DTOs (Data Transfer Objects)                     │
└─────────────────────────────────────────────────────┘
```

### 적용된 디자인 패턴
- **MVVM (Model-View-ViewModel)**: UI 로직 분리 및 테스트 용이성
- **Repository Pattern**: 데이터 접근 추상화
- **Coordinator Pattern**: 네비게이션 로직 중앙화
- **Dependency Injection**: Swinject를 통한 의존성 관리
- **Assembly Pattern**: 모듈별 DI 구성

## 모듈 구조

```
ENMApp/
├── Workspace.swift                # Tuist 워크스페이스 설정
├── Tuist/
│   └── Package.swift              # 외부 의존성 정의
└── Projects/
    ├── App/                       # 메인 애플리케이션
    │   └── ENMApp/
    └── Module/                    # 기능 모듈
        ├── Domain/                # 비즈니스 로직 계층
        │   └── HomeDomain/
        │       ├── Entities/      # 도메인 모델
        │       ├── UseCases/      # 비즈니스 로직
        │       └── Repositories/  # Repository 인터페이스
        ├── Data/                  # 데이터 접근 계층
        │   └── HomeData/
        │       ├── Network/       # API 통신
        │       ├── DataSources/   # 데이터 소스
        │       └── Repositories/  # Repository 구현체
        ├── Feature/               # UI 기능 모듈
        │   ├── HomeFeature/       # 홈 화면
        │   └── HomeDetailFeature/ # 상세 화면
        ├── Service/               # 서비스 모듈
        │   └── HomeService/
        │       ├── DI/            # 의존성 주입 설정
        │       └── View/          # Coordinator
        ├── ENMUI/                 # 디자인 시스템
        │   └── Sources/
        │       ├── Components/    # UI 컴포넌트
        │       └── WebView/       # 웹뷰 관련
        ├── ENMFoundation/         # 공통 유틸리티
        └── Shared/                # 공유 모듈
            └── DI/                # 전역 DI 컨테이너
```

### 각 모듈의 역할

#### Domain Layer (HomeDomain)
- **역할**: 비즈니스 로직과 규칙 정의
- **특징**: 외부 프레임워크 의존성 없음 (Pure Swift)
- **주요 구성요소**:
  - `Product`: 상품 엔티티
  - `HomeUsecase`: 홈 화면 비즈니스 로직
  - `HomeRepository`: 데이터 접근 인터페이스

#### Data Layer (HomeData)
- **역할**: 데이터 접근 및 네트워크 통신
- **특징**: Repository 패턴 구현
- **주요 구성요소**:
  - `HomeProvider`: 네트워크 통신 담당
  - `HomeDataSource`: 데이터 소스 추상화
  - `HomeRepositoryImpl`: Repository 구현체
  - `HomeEndPoint`: API 엔드포인트 정의

#### Presentation Layer (Feature + Service)
- **역할**: UI 표현 및 사용자 상호작용
- **특징**: SwiftUI + MVVM 패턴
- **주요 구성요소**:
  - `HomeFeatureViewModel`: 홈 화면 뷰모델
  - `HomeDetailFeatureViewModel`: 상세 화면 뷰모델
  - `HomeCoordinator`: 네비게이션 관리

#### ENMUI (Design System)
- **역할**: 재사용 가능한 UI 컴포넌트
- **주요 컴포넌트**:
  - `ENMCardView`: 카드 UI (elevated, outlined, filled 스타일)
  - `ENMPriceView`: 가격 표시 컴포넌트
  - `ENMRatingView`: 평점 표시 컴포넌트
  - `ENMChipView`: 태그/필터 UI
  - `ENMAsyncImageView`: 비동기 이미지 로딩
  - `ENMWebView`: 웹뷰 래퍼

## 기술 스택

### 핵심 기술
- **언어**: Swift 6.0
- **UI 프레임워크**: SwiftUI
- **최소 지원 버전**: iOS 17.0+
- **프로젝트 관리**: Tuist 4.x

### 주요 라이브러리
- **Swinject** (2.9.1): 의존성 주입 프레임워크
  - Assembly 패턴을 통한 모듈별 DI 구성
  - 타입 안전한 의존성 해결

### 아키텍처 패턴
- **Clean Architecture**: 계층 분리 및 의존성 역전
- **MVVM**: Presentation 계층 패턴
- **Repository Pattern**: 데이터 접근 추상화
- **Coordinator Pattern**: 네비게이션 관리
- **Dependency Injection**: 의존성 관리

## 설치 및 실행 방법

### 사전 요구사항
1. **macOS**: Ventura 13.0 이상
2. **Xcode**: 15.0 이상
3. **Tuist**: 4.x 버전

### Tuist 설치
```bash
# Homebrew를 통한 설치 (권장)
brew install tuist

# 또는 Mise를 통한 설치
mise install tuist

# 설치 확인
tuist version
```

### 프로젝트 설정 및 빌드

1. **저장소 클론**
```bash
git clone [repository-url]
cd ENMApp
```

2. **의존성 설치**
```bash
# Tuist가 외부 의존성(Swinject)을 자동으로 다운로드하고 설치합니다
tuist install
```

3. **프로젝트 생성**
```bash
# Xcode 프로젝트 파일 생성
tuist generate
```

4. **Xcode에서 열기**
```bash
# 생성된 워크스페이스를 Xcode에서 열기
open ENMApp.xcworkspace
```

5. **빌드 및 실행**
- Xcode에서 `ENMApp` 스킴 선택
- 시뮬레이터 또는 실제 디바이스 선택
- `Cmd + R`로 빌드 및 실행

### Tuist 주요 명령어

```bash
# 프로젝트 생성
tuist generate

# 프로젝트 정리
tuist clean

# 의존성 업데이트
tuist install --update

# 프로젝트 편집 (Tuist 설정 파일)
tuist edit

```

## 📂 코드 구조 및 네비게이션 가이드

### 주요 진입점
1. **앱 시작점**: `Projects/App/ENMApp/Sources/ENMAppApp.swift`
2. **DI 설정**: `Projects/Module/Service/HomeService/Sources/DI/DI+Home.swift`
3. **홈 화면**: `Projects/Module/Feature/HomeFeature/`
4. **디자인 시스템**: `Projects/Module/ENMUI/Sources/`

### 새로운 기능 추가 시
1. **Domain 모듈**: 비즈니스 로직 정의
2. **Data 모듈**: 데이터 접근 구현
3. **Feature 모듈**: UI 구현
4. **Service 모듈**: DI 설정 및 Coordinator 추가

## 🧪 테스트

### 단위 테스트 실행
```bash
# 전체 테스트 실행
tuist test

# 특정 모듈 테스트
tuist test HomeDomainTests
```

### 테스트 구조
- `Tests/` 폴더: 각 모듈별 테스트
- `TestSupport/` 폴더: 테스트 헬퍼 및 Mock 객체

## 📝 문서화

프로젝트는 Swift Documentation Comments를 사용하여 문서화되어 있습니다.

### Xcode에서 문서 보기
1. Xcode에서 프로젝트 열기
2. `Product` → `Build Documentation` 선택
3. 생성된 문서에서 API 레퍼런스 확인

### 주요 문서화 영역
- 모든 public API
- 사용 예제 포함
- 파라미터 및 반환값 설명
- 주의사항 및 팁

## 프로젝트 구조의 장점

1. **모듈화**: 각 기능이 독립적인 모듈로 분리되어 재사용성과 테스트 용이성 향상
2. **의존성 역전**: Domain 계층이 외부 프레임워크에 의존하지 않음
3. **테스트 용이성**: 각 계층이 인터페이스로 분리되어 Mock 테스트 가능
4. **확장성**: 새로운 기능 추가 시 기존 코드 수정 최소화
5. **유지보수성**: 명확한 책임 분리로 코드 이해도 향상

## 기여 가이드

1. Feature 브랜치 생성: `feature/기능명`
2. 커밋 메시지 컨벤션 준수
3. 코드 리뷰 후 머지
4. 모든 public API에 문서화 필수
